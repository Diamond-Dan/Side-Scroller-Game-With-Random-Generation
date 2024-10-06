from cx_Freeze import setup, Executable

setup(
    name="sound_effects_api",
    version="0.1",
    description="Sound Effects API",
    executables=[Executable("sound_effects_api.py")],
    options={
        'build_exe': {
            'packages': ['flask', 'sound_effects'],
            'includes': ['scipy.special.cdflib'],
            'include_files': [],  # Add any additional files you need to include
        }
    }
)