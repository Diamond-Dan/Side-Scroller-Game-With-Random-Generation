from flask import Flask, jsonify, Blueprint, request, abort
import sound_effects

app = Flask(__name__)
@app.route('/generate_sounds', methods=['POST'])
def generate_sounds():
    data = request.get_json()
    file_loc = []
    sound_type = data.get('sound_type')

    if not data:
        print("No data provided")
        abort(400, description="No data provided")

    if sound_type is None:
        print("Missing sound_type field")
        abort(400, description="Missing sound_type field")

    if sound_type not in ['laser', 'explosion', 'engine']:
        print("Invalid sound_type")
        abort(400, description="Invalid sound_type")

    if sound_type == 'laser':
        file_loc.append(sound_effects.laser_sound())
    elif sound_type == 'explosion':
        file_loc.append(sound_effects.explosion_sound())
    elif sound_type == 'engine':
        file_loc.append(sound_effects.flying_noise())

    print(file_loc)
    return jsonify(file_loc)


if __name__ == '__main__':
    app.run(port=5005, debug=True)