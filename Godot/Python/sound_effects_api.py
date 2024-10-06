from flask import Flask, jsonify, Blueprint, request, abort
import sys
import os
import sound_effects

app = Flask(__name__)
@app.route('/generate_sounds', methods=['POST'])
def generate_sounds():
    data = request.get_json()
    file_names = []
    sound_effects_url = {}
    sound_type = data.get('sound_type')
    

    if getattr(sys, 'frozen', False):
        # If the application is run as a bundle, the PyInstaller bootloader
        # extends the sys module by a flag frozen=True and sets the app path
        cur_dir = os.path.dirname(sys.executable)
    else:
        # If the application is run as a simple script, this will be the path
        cur_dir = os.path.dirname(os.path.abspath(__file__))
    
    print(cur_dir)

    if not data:
        print("No data provided")
     
        abort(400, description="No data provided")

    if sound_type is None:
        print("Missing sound_type field")
     
        abort(400, description="Missing sound_type field")

    if sound_type not in ['laser', 'explosion', 'engine', 'all']:
        print("Invalid sound_type")
        
        abort(400, description="Invalid sound_type")

    if sound_type == 'laser':
        file_names.append(sound_effects.laser_sound(cur_dir))
        sound_effects_url["laser"] = 'http://localhost:5005/sounds/' + file_names[0] + '.mp3'
    elif sound_type == 'explosion':
        file_names.append(sound_effects.explosion_sound(cur_dir))
        sound_effects_url["explosion"] = 'http://localhost:5005/sounds/' + file_names[0] + '.mp3'
    elif sound_type == 'engine':
        file_names.append(sound_effects.flying_noise(cur_dir))
        sound_effects_url["engine"] = 'http://localhost:5005/sounds/' + file_names[0] + '.mp3'
    elif sound_type == 'all':
        file_names.append(sound_effects.laser_sound(cur_dir))
        file_names.append(sound_effects.explosion_sound(cur_dir))
        flying_noise = sound_effects.flying_noise(cur_dir)
        file_names.append(flying_noise[0])
        file_names.append(flying_noise[1])

        sound_effects_url = {
            "laser": 'http://localhost:5005/sounds/' + file_names[0] + '.mp3',
            "explosion": 'http://localhost:5005/sounds/' + file_names[1] + '.mp3',
            "engine": 'http://localhost:5005/sounds/' + file_names[2] + '.mp3',
            "afterburner": 'http://localhost:5005/sounds/' + file_names[3] + '.mp3'
        }

    return jsonify(sound_effects_url)


if __name__ == '__main__':
    app.run(port=5005, debug=True)