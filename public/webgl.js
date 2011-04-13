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

    shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix");
    shaderProgram.mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix");
}

var mvMatrix = mat4.create();
var pMatrix = mat4.create();

function setMatrixUniforms(){
    gl.uniformMatrix4fv(shaderProgram.pMatrixUniform, false, pMatrix);
    gl.uniformMatrix4fv(shaderProgram.mvMatrixUniform, false, mvMatrix);
}

var ichigoVertexPositionBuffer;
var ichigoVertexIndexBuffer;

function initBuffers(skin_control){
    var positions = $(skin_control).find('MeshGeometry3D\\.Positions')[0];
    var points = $(positions).find('Point3D');
    var indices = $(skin_control).find('MeshGeometry3D\\.TriangleIndices').text().split(/[\,\n]/);
    indices.shift();

    ichigoVertexPositionBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, ichigoVertexPositionBuffer);

    var vertices = points.map(function(){
	return [this.getAttribute('X'),
		this.getAttribute('Y'),
		this.getAttribute('Z')];
    });

    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
    ichigoVertexPositionBuffer.itemSize = 3;
    ichigoVertexPositionBuffer.numItems = points.length;

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
	    initBuffers(skin_control);
	    
	    gl.clearColor(0.0, 0.0, 0.0, 1.0);
	    gl.enable(gl.DEPTH_TEST);
	    
	    tick();
	}
    });
});
