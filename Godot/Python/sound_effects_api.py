from flask import Flask, jsonify, Blueprint, request, abort
import sound_effects

app = Flask(__name__)
@app.route('/generate_sounds', methods=['POST'])
def generate_sounds():
    data = request.get_json()
    file_names = []
    sound_type = data.get('sound_type')

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
        file_names.append(sound_effects.laser_sound())
    elif sound_type == 'explosion':
        file_names.append(sound_effects.explosion_sound())
    elif sound_type == 'engine':
        file_names.append(sound_effects.flying_noise())
    elif sound_type == 'all':
        file_names.append(sound_effects.laser_sound())
        file_names.append(sound_effects.explosion_sound())
        flying_noise = sound_effects.flying_noise()
        file_names.append(flying_noise[0])
        file_names.append(flying_noise[1])

        sound_effects_url = {
            "laser": 'http://localhost:5005/sounds/' + file_names[0] + '.wav',
            "explosion": 'http://localhost:5005/sounds/' + file_names[1] + '.wav',
            "engine": 'http://localhost:5005/sounds/' + file_names[2] + '.wav',
            "afterburner": 'http://localhost:5005/sounds/' + file_names[3] + '.wav'
        }
    return jsonify(sound_effects_url)


if __name__ == '__main__':
    app.run(port=5005, debug=True)