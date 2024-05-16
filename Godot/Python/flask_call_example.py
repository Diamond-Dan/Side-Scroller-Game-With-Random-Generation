import requests
import webbrowser
#url to requset from
url = "http://localhost:5000/generate_images_criteria"

# Define the data to send
data = {
    'start_x' : 50,
	'start_y' : 50,
	'frames' : 10,
	'seed' : 3,
	'pixel_number' : 100,
	'mode' : "2",
	'wiggle' :3,
	'xml' :'tie_fighter.oxs',
	'pixel_size' : 2,
	'file_name' : "asteroid"
}


response = requests.post(url, json=data)


print("GENERATING GUIDED IMAGES\n \n")
#json with list of urls
print(response.json())
#auto open windows from json
for url in response.json().values():
    webbrowser.open_new(url)
#url to requset from
url2 ="http://localhost:5000/generate_random_images"


response2 = requests.post(url2)
print("GENERATING RANDOM IMAGES\n \n")
#json with list of urls
print(response2.json())