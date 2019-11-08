FROM ubuntu:bionic

# Install prereqs
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	build-essential \
	ca-certificates \
	debhelper \
	git \
	libcapture-tiny-perl \
	libconfig-inifiles-perl \
	lzop \
	mbuffer \
	pv && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Get Sanoid repo
WORKDIR /tmp
RUN git clone https://github.com/jimsalterjrs/sanoid.git

# Build Sanoid
WORKDIR /tmp/sanoid
RUN ln -s packages/debian .
RUN dpkg-buildpackage -uc -us

# Copy Sanoid to output dir and be done
CMD echo "Copying sanoid_*_all.deb to /output/..." && \
	cp -v ../sanoid_*_all.deb /output/ && \
	echo "That's all, folks!"
