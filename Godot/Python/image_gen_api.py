from flask import Flask, send_file
from PIL import Image
import io


app = Flask(__name__)

@app.route('/image', methods=['GET'])
def get_image():
    # Call your function to generate the image
    image_name = draw_image_guided_explode(...)  # Fill in your parameters here

    # Open the image file
    img = Image.open(image_name)

    # Save the image to a BytesIO object
    byte_data = io.BytesIO()
    img.save(byte_data, format='PNG')
    byte_data = byte_data.getvalue()

    # Create a response with the image data
    response = send_file(
        io.BytesIO(byte_data),
        mimetype='image/png',
    )

    return response

@app.route('/gif', methods=['GET'])
def get_gif():
    # Call your function to generate the GIF
    gif_name = create_gif(...)  # Fill in your parameters here

    # Open the GIF file
    gif = open(gif_name, 'rb')

    # Create a response with the GIF data
    response = send_file(
        io.BytesIO(gif.read()),
        mimetype='image/gif',
    )

    return response

if __name__ == '__main__':
    app.run(debug=True)