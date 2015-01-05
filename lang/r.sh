# http://sites.psu.edu/theubunturblog/installing-r-in-ubuntu/

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 

# add CRAN repository to sources.list
sudo bash -c "echo 'deb http://cran.r-project.org/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list"

echo "Downloading R..."
sudo apt-get update -qq && sudo apt-get install r-base r-base-dev -y