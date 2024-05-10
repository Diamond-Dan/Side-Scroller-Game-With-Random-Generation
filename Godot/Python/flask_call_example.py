from flask import Flask, jsonify
import requests

app = Flask(__name__)
@app.route('/call_image_gen_api')
def call_image_gen_api():
    # Make a GET request to the /generate_images route of the image_gen_api.py application
    response = requests.get('http://localhost:5000/generate_images')

    # Check if the request was successful
    if response.status_code == 200:
        # Get the image URLs from the response
        image_urls = response.json()

        # Print the image URLs to the terminal
        for name, url in image_urls.items():
            print(f'{name}: {url}')

        # Return the image URLs in the API response
        return jsonify(image_urls)

    else:
        # If the request was not successful, return an error message
        return jsonify({'error': 'Could not generate images'})

if __name__ == '__main__':
    app.run(debug=True, port=5001)