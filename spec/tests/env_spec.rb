require "serverspec"
require "docker"

set :backend, :docker

describe "Dockerfile" do
  before(:all) do
    @container = Docker::Container.create(
      :Image => ENV['DOCKER_IMAGE_NAME'] + ':' + ENV['DOCKER_IMAGE_TAG'],
      :Tty => true,
      :Cmd => 'bash'
    )
    @container.start
    set :docker_container, @container.id
  end

  describe file('/etc/alpine-release') do
    its(:content) { should match "^3\.4\." }
  end

  describe command('awk \'/^Uid:/{print $2}\' /proc/1/status') do
    its(:stdout) { should eq "1000\n" }
  end

  describe command('su-exec app id -u') do
    its(:stdout) { should eq "1000\n" }
  end

  describe command('su-exec app id -g') do
    its(:stdout) { should eq "1000\n" }
  end

  describe command('make -v') do
    its(:exit_status) { should eq 0 }
  end

  after(:all) do
    if !@container.nil?
      @container.delete(:force => true)
    end
  end
end
