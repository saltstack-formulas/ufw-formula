control 'UFW package' do
  title 'should be installed'

  describe package('ufw') do
    it { should be_installed }
  end
end
