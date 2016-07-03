workers Integer(ENV['PUMA_WORKER'] || 2)
threads 0, 16

bind 'tcp://127.0.0.1:8080'
