#!python
'''
Created on 19.02.2010

@author: Inf
'''
from plistlib import writePlist, readPlist
from os.path import basename
from optparse import OptionParser

from PIL import Image, ImageChops 

def trim(image):
    mask = Image.new(image.mode, image.size, (0, 0, 0, 0))
    diff = ImageChops.difference(image, mask)
    
    bbox = diff.getbbox()
    
    if bbox:
        return image.crop(bbox)
    return image

class TreeNode(object):
    
    def __init__(self):
        self.child1 = None
        self.child2 = None
        self.rect = (0,0,0,0)
        self.image = None
       
    @property 
    def isNotLeaf(self):
        return self.child1 is not None or self.child2 is not None
    
    @property
    def width(self):
        return self.rect[2]
    
    @property 
    def height(self):
        return self.rect[3]
    
    @property
    def left(self):
        return self.rect[0]
    
    @property
    def top(self):
        return self.rect[1]
    
    @property
    def right(self):
        return self.left + self.width
    
    @property
    def bottom(self):
        return self.top + self.height
     
    def add_image(self, image):
        if self.isNotLeaf:
            node = None
            if self.child1 is not None:
                node = self.child1.add_image(image)
            if node is None and self.child2 is not None:
                node = self.child2.add_image(image)
            return node
        else:
            if self.image is not None:
                return None
            
            if self.width < image.size[0] or self.height < image.size[1]:
                return None;
            
            if self.width == image.size[0] and self.height == image.size[1]:
                self.image = image 
                return self
            
            self.child1 = TreeNode()
            self.child2 = TreeNode()
            
            deltaWidth = self.width - image.size[0]
            deltaHeight = self.height - image.size[1]
            
            if deltaWidth > deltaHeight:
                self.child1.rect = (self.left, self.top, image.size[0], self.height)
                self.child2.rect = (self.left + image.size[0], self.top, deltaWidth, self.height)
            else:
                self.child1.rect = (self.left, self.top, self.width, image.size[1])
                self.child2.rect = (self.left, self.top + image.size[1], self.width, deltaHeight)
            
            return self.child1.add_image(image)   

class AtlasItem(object):
    
    def __init__(self, image):
        self.image = image
        self.x = 0
        self.y = 0
        
    @property
    def left_bound(self):
        return self.x + self.image.size[0]
    @property
    def bottom_bound(self):
        return self.y + self.image.size[1]
    

class AtlasBuilder(object):
    
    def __init__(self, name, width, height, append=False):
        self.name = name
        self.root = TreeNode()
        self.root.rect = (0, 0, width, height)
        self.atlas = Image.new('RGBA', (width, height), (0, 0, 0, 0))
        if append:
            self.descriptor = readPlist('textures.plist')
        else:
            self.descriptor = dict()
    
    def add_path(self, path):
        image = Image.open(path)
        trimmed = trim(image)
        node = self.root.add_image(trimmed)
        
        if node is None:
            raise ValueError('Not enough place for %s' % (path))
        self.atlas.paste(node.image, (node.left, node.top))

        texture_name = basename(path)
        self.descriptor[texture_name] = dict(atlas=self.name, 
                                     left=self.to_u_texcoord(node.left), 
                                     top=self.to_v_texcoord(node.top), 
                                     right=self.to_u_texcoord(node.right), 
                                     bottom=self.to_v_texcoord(node.bottom),
                                     width=trimmed.size[0],
                                     height=trimmed.size[1])
        
    def save_image(self, path):
        self.atlas.save(path)
        
    def save_descriptor(self, path):
        writePlist(self.descriptor, path)
        
    def save(self):
        self.save_image(self.name)
        self.save_descriptor('textures.plist')
    
    def to_u_texcoord(self, x):
        return float(x) / float(self.root.width)
    
    def to_v_texcoord(self, y):
        return float(y) / float(self.root.height)
        
        

    
if __name__ == '__main__':
    parser = OptionParser(usage='make_atlas.py -o FILENAME --width=WIDTH --height=HEIGHT [--append] files')
    parser.add_option('-o', '--output', action='store', dest='filename', 
                      help='name of output texture')
    parser.add_option('--width', action='store', type='int', dest='width',
                      help='width of output texture')
    parser.add_option('--height', action='store', type='int', dest='height',
                      help='height of output texture')
    parser.add_option('-a', '--append', action='store_true', dest='append', default=False,
                      help="don't create new textures.plist, append to existing")
    
    
    options, files = parser.parse_args()
    width = options.width
    height = options.height
    name = options.filename
    append = options.append
    
    atlas = AtlasBuilder(name, width, height, append)
    
    for file in files:
        atlas.add_path(file)
    
    atlas.save()
