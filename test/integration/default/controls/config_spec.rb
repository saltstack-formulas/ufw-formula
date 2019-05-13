control 'UFW configuration' do

  title 'Test UFW configuration'

  describe directory('/etc/ufw') do
    it { should exist }
  end

  describe file('/etc/ufw/ufw.conf') do
    its('content') { should include 'ENABLED=' }
    its('content') { should include 'LOGLEVEL=' }
  end

  describe command('ufw status verbose | grep Status') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /active/ }
  end

  describe command('ufw status verbose | grep Logging') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /low/ }
  end

  describe command('ufw status | grep MySQL') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /ALLOW/ }
  end

  describe command('ufw status | grep Postgresql') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /LIMIT/ }
  end

  describe command('ufw status | grep SSH223') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /DENY/ }
  end

  describe command('ufw status | grep 10.0.0.0') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /DENY/ }
  end

  describe command('ufw status | grep 22/tcp') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /LIMIT/ }
  end

  describe command('ufw status | grep 80/tcp') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /DENY/ }
  end

  describe command('ufw status | grep 443/tcp') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /ALLOW/ }
  end

  describe command('ufw status | grep 10.0.0.1') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /DENY/ }
  end

  describe command('ufw status | grep 10.0.0.2') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /DENY/ }
  end
end
