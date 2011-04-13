var gl;
function initGL(canvas){
    try {
        gl = canvas.getContext("experimental-webgl");
        gl.viewportWidth = canvas.width;
        gl.viewportHeight = canvas.height;
    }catch(e){
    }
    if(!gl){
        alert("Could not initialize WebGL");
    }
}

function getShader(gl, id){
    var shaderScript = document.getElementById(id);
    if(!shaderScript){
	alert("element not found:" + id);
        return null;
    }

    var str = "";
    var k = shaderScript.firstChild;
    while(k){
	if(k.nodeType == 3){
	    str += k.textContent;
	}
	k = k.nextSibling;
    }

    var shader;
    if(shaderScript.type == "x-shader/x-fragment") {
	shader = gl.createShader(gl.FRAGMENT_SHADER);
    }else if(shaderScript.type == "x-shader/x-vertex"){
	shader = gl.createShader(gl.VERTEX_SHADER);
    }else{
	return null;
    }

    gl.shaderSource(shader, str);
    gl.compileShader(shader);
    
    if(!gl.getShaderParameter(shader, gl.COMPILE_STATUS)){
	alert(gl.getShaderInfoLog(shader));
	return null;
    }

    return shader;
}

var shaderProgram;
function initShaders(){
    var fragmentShader = getShader(gl, "shader-fs");
    var vertexShader = getShader(gl, "shader-vs");
    
    shaderProgram = gl.createProgram();
    gl.attachShader(shaderProgram, vertexShader);
    gl.attachShader(shaderProgram, fragmentShader);
    gl.linkProgram(shaderProgram);

    if(!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)){
        alert("Could not initialize shaders");
    }

    gl.useProgram(shaderProgram);
          
    shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition");
    gl.enableVertexAttribArray(shaderProgram.vertexPositionAttribute);

    shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord");
    gl.enableVertexAttribArray(shaderProgram.textureCoordAttribute);

    shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix");
    shaderProgram.mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix");
    shaderProgram.samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler");
}

var mvMatrix = mat4.create();
var pMatrix = mat4.create();

function setMatrixUniforms(){
    gl.uniformMatrix4fv(shaderProgram.pMatrixUniform, false, pMatrix);
    gl.uniformMatrix4fv(shaderProgram.mvMatrixUniform, false, mvMatrix);
}

var ichigoTexture;

function initTexture(){
    ichigoTexture = gl.createTexture();
    ichigoTexture.image = new Image();
    ichigoTexture.image.onload = function(){
	handleLoadedTexture(ichigoTexture);
    }
    
    ichigoTexture.image.src = "ichigo.png";
}

function handleLoadedTexture(texture){
    gl.bindTexture(gl.TEXTURE_2D, texture);
    // gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
    gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.bindTexture(gl.TEXTURE_2D, null);
}

var ichigoVertexPositionBuffer;
var ichigoVertexTextureCoordBuffer;
var ichigoVertexIndexBuffer;

function initBuffers(skin_control){
    ichigoVertexPositionBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, ichigoVertexPositionBuffer);

    var positions = $(skin_control).find('MeshGeometry3D\\.Positions')[0];
    var points = $(positions).find('Point3D');
    var vertices = points.map(function(){
	return [this.getAttribute('X'),
		this.getAttribute('Y'),
		this.getAttribute('Z')];
    });
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
    ichigoVertexPositionBuffer.itemSize = 3;
    ichigoVertexPositionBuffer.numItems = points.length;

    ichigoVertexTextureCoordBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, ichigoVertexTextureCoordBuffer);
    var textureCoordinates = $(skin_control).find('MeshGeometry3D\\.TextureCoordinates')[0];
    var uvs = $(textureCoordinates).find('Point');
    var textureCoords = uvs.map(function(){
	return [this.getAttribute("X"),
		this.getAttribute("Y")];
    });
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(textureCoords), gl.STATIC_DRAW);
    ichigoVertexTextureCoordBuffer.itemSize = 2;
    ichigoVertexTextureCoordBuffer.numItems = uvs.length;

    var indices = $(skin_control).find('MeshGeometry3D\\.TriangleIndices').text().split(/[\,\n]/);
    indices.shift();
    ichigoVertexIndexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ichigoVertexIndexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Int16Array(indices), gl.STATIC_DRAW);
    ichigoVertexIndexBuffer.itemSize = 3;
    ichigoVertexIndexBuffer.numItems = indices.length;
}

var r = 0;

function drawScene(){
    gl.viewport(0, 0, gl.viewportWidth, gl.viewportHeight);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    
    mat4.perspective(45, gl.viewportWidth / gl.viewportHeight, 10.0, 10000.0, pMatrix);

    mat4.identity(mvMatrix);
    mat4.rotate(mvMatrix, -Math.PI/2, [1, 0, 0]);
    mat4.translate(mvMatrix, [0.0, 200.0, -70.0]);

    mat4.rotate(mvMatrix, r, [0, 0, 1]);

    gl.bindBuffer(gl.ARRAY_BUFFER, ichigoVertexPositionBuffer);
    gl.vertexAttribPointer(shaderProgram.vertexPositionAttribute, ichigoVertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0);

    gl.bindBuffer(gl.ARRAY_BUFFER, ichigoVertexTextureCoordBuffer);
    gl.vertexAttribPointer(shaderProgram.textureCoordAttribute, ichigoVertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0);

    gl.activeTexture(gl.TEXTURE0);
    gl.bindTexture(gl.TEXTURE_2D, ichigoTexture);
    gl.uniform1i(shaderProgram.samplerUniform, 0);

    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ichigoVertexIndexBuffer);
    setMatrixUniforms();  
    // gl.drawArrays(gl.TRIANGLES, 0, ichigoVertexPositionBuffer.numItems);
    gl.drawElements(gl.TRIANGLES, ichigoVertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0);
}

var lastTime = 0;

function animate(){
    var timeNow = new Date().getTime();
    if(lastTime != 0){
	var elapsed = timeNow - lastTime;
	r += (Math.PI * elapsed) / 2000.0;
    }
    lastTime = timeNow;
}

function tick(){
    requestAnimFrame(tick);
    drawScene();
    animate();
}

$(document).ready(function(){
    $.ajax({
	url:'ichigo.xml',
	success:function(xml){
	    var skin_control = $(xml).find('[Name="skinControl"]')[0];

	    var canvas = $('#mycanvas')[0];
	    initGL(canvas);
	    initShaders();
	    initTexture();
	    initBuffers(skin_control);
	    
	    gl.clearColor(0.0, 0.0, 0.5, 1.0);
	    gl.enable(gl.DEPTH_TEST);
	    
	    tick();
	}
    });
});
