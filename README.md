# Video-to-text
* Create Account on Google Cloud Platform: https://console.cloud.google.com/
* Create a Project
* Enable speech to text google API
* IAM -> Service Accounts -> Create Service Account -> Add unique name -> Set Role -> Create Key -> Download Json
* Goto Storage -> create bucket
* Write Code
* Run command from console: export GOOGLE_APPLICATION_CREDENTIALS='file_name.json'
* Run command: Ruby translate_video_to_text.rb
