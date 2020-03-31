require "google/cloud/speech"
require "google/cloud/storage"

# project_id = "hip-apricot-261512"
# key_file   = "My_project_key.json"
project_id = "clean-evening-261613"
key_file   = "clean-evening-project-credentials.json"


# # Conver video to audio
system "ffmpeg -i video23.mp4 video_test.flac"
system "ffmpeg -i video_test.flac -ac 1 video_test_flac.flac"

# # # # Upload audio to Google Storage
storage = Google::Cloud::Storage.new project: project_id, keyfile: key_file


bucket_name = storage.buckets.first.name
puts bucket_name
bucket  = storage.bucket bucket_name
local_file_path = '/Users/mac/Downloads/video_test_flac.flac'
file = bucket.create_file local_file_path, 'video_cloud.flac'
puts "Uploaded #{file.name}"

# Translate audio to text
speech = Google::Cloud::Speech.new
storage_path = "gs://audio_bucket-1/video_cloud.flac"
# storage_path = "gs://audio_bucket-1/video_Dec_20_2019_12_46_41_GMT-mono.flac"

config = { encoding: :FLAC,
        language_code: "de-DE" }
audio = { uri: storage_path }
operation = speech.long_running_recognize config, audio

audio_text = ''
puts "Operation started"
if !operation.nil?
    operation.wait_until_done!
    raise operation.results.message if operation.error?
    results = operation.response.results
    results.each do |result|
        audio_text << result.alternatives.first.transcript
        puts "Transcription: #{result.alternatives.first.transcript}"
    end
end

puts audio_text
