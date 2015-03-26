Eye.application 'consul' do
  working_dir '/'
  stdall '/var/log/eye/consul-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :consul do
    pid_file '/var/run/consul-eye.pid'
    start_command '/bin/consul agent -config-dir=/config -advertise 10.0.1.1 -join sverka-05.node.dc1.consul'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
