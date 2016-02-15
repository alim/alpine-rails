# Introduction

This Docker container image build is designed to produce a lightweight
Ruby-on-Rails Docker container. It's based on an Alpine Linux version of
the official Ruby container. The resulting container image should be about
half the size of the official Rails container. The Dockerfile sets up the
necessary libraries needed to install Rails and its dependencies, but *does not*
actually install Rails. It is designed to be used as a parent Docker file
for your Rails application.  This approach keeps the container smaller and
will only bundle in the Ruby Gems specified by your Rails application.

# Usage

The steps for using this container are as follows:

1. Create a Dockerfile in the root directory of your Rails application
2. Either build the container locally our part of a Docker Hub automated build sequence.
3. Run the container with the appropriate environment variables needed for your application.

# Examples

Example Dockerfiles that can be included in your Rails application are shown
below:

TBD
