from flask import Flask, jsonify, Blueprint
import random
import os
import sprite_micro_gen
app = Flask(__name__)
# Create a blueprint for the first static folder
images_blueprint = Blueprint('images', __name__, static_folder='images', static_url_path='/images')
app.register_blueprint(images_blueprint)

# Create a blueprint for the second static folder
gifs_blueprint = Blueprint('gifs', __name__, static_folder='gifs', static_url_path='/gifs')
app.register_blueprint(gifs_blueprint)
@app.route('/generate_images')
def generate_images():
    # Call the main function
    start_x = random.randint(40, 70)
    start_y = random.randint(40, 70)
    frames = random.randint(1, 10)
    seed = random.randint(0, 100)
    pixel_number = random.randint(100, 200)
    mode = random.choice(['1','2','3'])
    wiggle = random.randint(1,5)
    xml = 'tie_fighter.oxs'
    pixel_size = random.randint(1, 5)
    file_name = "server_image"
    filename,filename_2,gif_loc_1,gif_loc_2=sprite_micro_gen.main(start_x, start_y, frames, seed, pixel_number, mode, wiggle, xml, pixel_size, file_name,server_mode=True)
    print(filename,filename_2,gif_loc_1,gif_loc_2)
    # Create URLs for each image file
    image_urls = {
        'gif_loc_1': 'http://localhost:5000/gifs/' + gif_loc_1.replace("\\", "/"),
        'gif_loc_2': 'http://localhost:5000/gifs/' + gif_loc_2.replace("\\", "/")
    }
    for i, name in enumerate(filename, start=1):
        image_urls[f'filename_{i}'] = f'http://localhost:5000/images/{name}'.replace("\\", "/")
    for i, name in enumerate(filename_2, start=1):
        image_urls[f'filename_2_{i}'] = f'http://localhost:5000/images/{name}'.replace("\\", "/")
  
    for name, url in image_urls.items():
        print(f'{name}: {url}')
    # Return the image URLs in the API response
    return jsonify(image_urls)
if __name__ == '__main__':
    app.run(debug=True)