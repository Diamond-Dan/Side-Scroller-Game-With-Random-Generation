import requests

def test_generate_random_images():
    # Example data for generating a food image
    data = {
        'x': 80,
        'y': 50,
        'seed': 1,
        'pixel_number': 300
    }

    # URL to your Flask endpoint
    url = 'http://127.0.0.1:5000/generate_random_images'

    # Sending POST request to the Flask server
    response = requests.post(url, json=data)

    # Print the response from server
    print(response.text)

if __name__ == "__main__":
    test_generate_random_images()
