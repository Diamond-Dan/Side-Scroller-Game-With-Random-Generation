import requests
import webbrowser
import json
import os

url = "http://127.0.0.1:5000/generate_random_images"
data = {
    'start_x': 50,
    'start_y': 50,
    'frames': 10,
    'seed': 3,
    'pixel_number': 100,
    'mode': "2",
    'wiggle': 3,
    'xml': 'tie_fighter.oxs',
    'pixel_size': 2,
    'file_name': "asteroid"
}

# Define the directory for saving downloaded GIFs
download_directory = os.path.join(os.path.dirname(__file__), 'gifs')
if not os.path.exists(download_directory):
    os.makedirs(download_directory)

# Ensure to handle exceptions for network errors and JSON decoding explicitly
response = requests.post(url, json=data)
if response.status_code == 200:
    response_data = response.json()
    for key, url in response_data.items():
        if 'gif' in key:
            # Download and save the GIF
            gif_response = requests.get(url)
            if gif_response.status_code == 200:
                gif_path = os.path.join(download_directory, os.path.basename(url))
                with open(gif_path, 'wb') as f:
                    f.write(gif_response.content)
                print(f"Saved GIF to {gif_path}")
                # Optionally open the GIF with the default viewer
                webbrowser.open(gif_path)
            else:
                print(f"Failed to download {url}")
        else:
            print(f"{key}: {url}")
else:
    print("Failed to retrieve data:", response.status_code, response.text)