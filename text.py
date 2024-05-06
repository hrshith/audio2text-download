from flask import Flask, render_template, request, make_response
import os
import whisper
from tempfile import NamedTemporaryFile

app = Flask(__name__)

# Load the Whisper model
model = whisper.load_model("base")

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    error = None
    text_output = None
    download_url = '/download_text'

    if request.method == 'POST':
        uploaded_file = request.files['file']
        if uploaded_file.filename != '':
            with NamedTemporaryFile(delete=False) as temp_file:
                uploaded_file.save(temp_file.name)
                file_path = temp_file.name

            try:
                # Process audio file through Whisper model
                result = model.transcribe(file_path)
                text_output = result["text"]
            except Exception as e:
                error = str(e)
            finally:
                # Delete the temporary file
                os.remove(file_path)

    return render_template('index.html', text_output=text_output, error=error, download_url=download_url)

@app.route('/download_text', methods=['GET'])
def download_text():
    text_output = request.args.get('text_output')
    if text_output:
        response = make_response(text_output)
        response.headers["Content-Disposition"] = "attachment; filename=transcription.txt"
        return response
    else:
        return "No text output to download."

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
