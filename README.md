# 361_project
Sprint Milestone 1:

•	Part 1: Environment Setup. Initialize your GitHub repository, investigate task management systems to organizing your project tasks.

•	Part 2: Course Project Plan. Write all the user stories you would like to be part of your Course Project. (It’s OK if you don’t implement all of them this term.)

•	Part 3: Sprint 1 Plan. Select at least three user stories to implement during Sprint 1 (for Milestone #1). Define detailed requirements for each user story.

Communication Contract

•   Download sprite_micro_gen.py, image_gen_api.py and flask_call_examply.py in the same file create three folders "Images", "gifs" and "patterns" with no quotes. Put the oxs pattern files in the pattern folders. When you run the script Images will be put in the Images folder and gifs in the gifs folder.

•   To request data from sprite_micro_gen.py you first must start image_gen_api.py it should show it running on port 5000 but you can run it on any port by chaning the port value at the bottom of image_gen_api.py. You can send a POST request to either "http://localhost:5000/generate_images_criteria" or "http://localhost:5000/generate_random_images" 

    For /generate_random_images you do not need to include json, be aware results will vary wildly

    For request to /generate_image_criteria you must insclude a json when you make the request, the criteria are as follows with definitions. In this format:
    datatype, defintion, Note:

    data = {
    'start_x' : int,The X value for where the image starts range is 0-100,
	'start_y' : int,The Y value for where the image starts range is 0-100,
    Note: if you want your images to be centered your x and y value should be 50
	'frames' : int, The number of frame in a animation generally it should be between 5-15,
	'seed' : int, random seed, this number can be anything between 1-1000
	'pixel_number' : int, this data type should not be over 500 the more pixes you have the more your images will be "filled"
	'mode' : string,"1" is random mode,
     "2" is xml mode which you can use the two provided xml files. These should be in a subfolder below your script called patterns
     "3" draws a circle shape like a planet
	'wiggle' :int, this is how much movement your pixels will do, best values are between 2-10
	'xml' :string, 'tie_fighter.oxs' and 'explode.oxs' are the only two currently provided
	'pixel_size' : int, how big your pixels should be, values between 1-5 are best but you can try larger values
	'file_name' : string,this is the name of your file
    }

•   To receive data you must parse the returned json for the location where the images will be hosted. The return will look something like this 

        'gif_loc_2': 'http://localhost:5000/gifs/movie_seed_10pixel_110frames_40.gif'

    You can parse the json for 'gif_loc_2:' and get back the address for the file.


