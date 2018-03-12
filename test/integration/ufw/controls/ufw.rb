# encoding: utf-8

title 'Test Ufw installation'

describe package('ufw') do
  it { should be_installed }
end

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

describe command('ufw status | grep 22/tcp') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /ALLOW/ }
end
