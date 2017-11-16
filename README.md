# objectivefs

# Description

This cookbook adds functionality for using (ObjectiveFS)[https://objectivefs.com/].  ObjectiveFS is:

> ObjectiveFS is a shared distributed POSIX file system that provides
> persistent data storage among your cloud instances, laptops, containers and
> office servers.

This cookbook will install the package and allows creation of ObjectiveFS mount
points.

# Requirements

 - Currently only supports Ubuntu 16.04 #FIXME.
 - A license for ObjectiveFS is necessary
 - The package must be downloaded from ObjectiveFS

# Use

ObjectiveFS requires a license and download of a package from behind a (login)[https://objectivefs.com/user/downloads].  Thus you must first download and determine another method of distributing this package within your organization.

Package installation in this cookbook (via the `default` recipe) assumes you
have incorporated the package into a local APT repository and will use `apt` to
install a package named `objectivefs` (the `.deb` distributed by ObjectiveFS
uses this name).

## Attributes

 - `objectivefs['package']`
   - `name`: The name of the package to install.  Defaults to "objectivefs"
   - `provider`: The Chef `package` resource provider to use for installation.
     Defaults to `Chef::Provider::Package`
   - `source`: Path to the `.deb` package when using the package provider `dpkg_package`


## Recipes

### `default`

The default recipe simply installs the package. Defaults use `apt` to install `objectivefs`

## Resources

### `ofs_mount`

`ofs_mount` will create a mount in the host's fstab.  Each mount will have its own configuration directory specified in the `env` attribute.  Currently the instance name is unused by the resource.

#### Syntax

An `ofs_mount` resource block creates and manages the configuration directory and mountpoint for an ObjectiveFS file system.

    ofs_mount 'test' do
      env '/etc/objectivefs.env'
      aws_access_key_id '1234'
      aws_default_region 'us-west'
      aws_secret_access_key 'abcdefg'
      objectivefs_license 'letmein'
      bucket_uri 's3://foo/bar'
      mount_point '/mnt/ofs_mount_test'
      action :mount
    end

#### Actions

This resource has the following actions:

 - `:create`: creates the configuration directory, populates the configuration files, and creates an entry in the host's file systems table (e.g. `fstab`).
 - `:mount`: mounts the indicated instance

#### Properties

 - `env`: The path to the ObjectiveFS configuration directory 
 - `aws_access_key_id`: An access key for the S3 bucket
 - `aws_secret_access_key`: The secret access key for the bucket
 - `aws_default_region`: The region containing the s3 bucket
 - `objectivefs_license`: The ObjectiveFS license
 - `bucket_uri`: The S3 URI for the ObjectiveFS bucket
 - `mount_point`: Where the  ObjectiveFS bucket will be mounted


# Development

An ObjectiveFS package is typically required for development.  Download and
place the objectivefs package in `test/assets/packages` and the `default`
recipe will be able to install it in the test-kitchen host.


