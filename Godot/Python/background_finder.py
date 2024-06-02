from flask import Flask, request, jsonify
import requests
from PIL import Image
from io import BytesIO
import base64
import os
app = Flask(__name__, static_folder='backgrounds')
@app.route('/request_image', methods=['GET'])
def request_image():
    url = 'http://127.0.0.1:7860/sdapi/v1/txt2img'
    myobj = {
    "prompt": "a background view of space, with a planet in the distance and a spaceship flying by, pixel art",
    "negative_prompt": "nudity",
    
    "seed": -1,
    "subseed": -1,
    "subseed_strength": 0,
    "seed_resize_from_h": -1,
    "seed_resize_from_w": -1,
    "batch_size": 1,
    "n_iter": 1,
    "steps": 20,
    "cfg_scale": 7,
    "width": 1024,
    "height": 512,
    "restore_faces": True,
    "tiling": True,
    "do_not_save_samples": False,
    "do_not_save_grid": False,
        "send_images": True,
    "save_images": False,

    }





    response = requests.post(url, json=myobj)
    image_list=[]
    # Check if the request was successful
    if response.status_code == 200:
        # Get the list of image URLs
        image_data_list = response.json()['images']

        for index, base64_string in enumerate(image_data_list):
            # Remove the quotes
            base64_string = base64_string.replace('"', '')

            # Decode the base64 string to get the image data
            image_data = base64.b64decode(base64_string)

            # Create a BytesIO object from the image data
            image_stream = BytesIO(image_data)

            # Create an Image object from the image stream
            image = Image.open(image_stream)
            curloc= os.getcwd()
            # Save the image to a location
            image.save(os.path.join(curloc, f"backgrounds/image_{index}.png"))
            
            image_list.append(f"http://localhost:5010/backgrounds/image_{index}.png")
        print(image_list)
        return jsonify({'image_0':image_list[0]}), 200

    else:
        return jsonify({'message': 'Request failed'}), 400


if __name__ == '__main__':
    app.run(debug=True, port=5010)          