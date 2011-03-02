import bpy.ops
import os

def clear_objects():
    for obj in bpy.context.scene.objects:
        bpy.context.scene.objects.unlink(obj)

def setup_scene():
    scene = bpy.context.scene
    scene.render.resolution_x = 320
    scene.render.resolution_y = 240
    scene.render.resolution_percentage = 100
    scene.layers[0] = True

def set_texture(obj, file):
    mat = obj.active_material
    mat.active_texture_index = 0
    mat.active_texture.type = 'IMAGE'
    mat.active_texture.image = bpy.data.images.load(file)
    mat.texture_slots[0].texture_coords = 'UV'

def load_setting(dir):
    files = os.listdir(dir)
    for file in files:
        if not(file.endswith(".tga")):
            continue
        name = file[0:len(file) - 4]
        obj = bpy.data.objects[name]
        obj.layers[0] = True
        bpy.context.scene.objects.link(obj)
        if obj.type == 'MESH':
            set_texture(obj, dir + "/" + file)        
        if obj.type == 'CAMERA':
            bpy.context.scene.camera = obj

clear_objects()
setup_scene()
load_setting(os.environ['WORK_DIR'])

bpy.ops.render.render()
img = bpy.data.images['Render Result']
img.save_render(os.environ['WORK_DIR'] + '/result.png')
