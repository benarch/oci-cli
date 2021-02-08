# OCI Compute shape compatibility change

Oracle Cloud Infrastructure (OCI) provides you the ability to edit and change your instance according to your needs. 
It also allows you to change your instance shape from Intel to AMD and vice versa.

In some cases, **older** images aren't supported and cannot be changed from one shape to another.
In those cases, when trying, you might receive the following error message:
`"Either the image isn't compatible with flexible shapes, or flexible shapes aren't supported in this availability domain."` [Learn More](https://www.npmjs.org/browse/keyword/markdown-it-plugin)


In this guide, i will show how to change shape platforms using OCI CLI.
First, you need to take in mind the following considerations.

## Considerations:
- If the instance is your production instance, do not perform it while it's running, this might affect the instance availability. In that case you can do the following:
  * Go to the instance, follow it's "boot volume", and perform a boot volume "clone".
  * Create an instance from that boot volume "clone".
  * Create a "custom image" from that instance (take in mind that "Custom Image" creation suspsends the 
  instance and affects it's availability).


  - In case your instance is not "production" and can be turned off, then create from your instance a custom image (take in mind that "Custom Image" creation suspsends the 
  instance and affects it's availability).
----
### ::: Disclaimer :::
###### This procedure is at your own risk!
###### It is not an Oracle's official procedure although it supports and using the OCI CLI.
###### Please backup your system before performing any changes and give yourself the ability to rollback.
###### Run this test on a standalone instance first before running it on your prodcution.
----

&nbsp;

Once you have your instance "custom image", copy it's OCID and access an OCI CLI (using your `oci cli` on your computer, or using [OCI CloudShell]) and run the following command:

```sh
oci compute image-shape-compatibility-entry add --image-id "<image-id>" --shape-name "$shape"
```

You need to replace the instance / object specific parameters to match your entities while executing the command.

| Command | README |
| ------ | ------ |
| --image-id | Your Image OCID |
| --shape-name | The Shape name you want to switch to |


This command is allows the image to participate in larger shape types. this command is part of achieved by the [OCI CLI] reference using the [image-shape-compatibility-entry].

that said, if i want to add your image be able to change from Intel based shape to an AMD based and you get the error from the console then you can look at this example to achieve your goal.

 
 
> Example:
>  From "VM.Standard2.2" shape to "VM.Standard.E3.Flex"&nbsp;
&nbsp;
> NOTE: the name of the shape is case sensitive.
```sh
oci compute image-shape-compatibility-entry add --image-id ocid1.image.oc1.eu-frankfurt-1.aaaabc543677.hellow0rldh3rewearegenerating50metextforexamples1234556 --shape-name VM.Standard.E3.Flex

```
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

A collegue (Avi), created a sample script that add's all the shapes to the image compatibility list.
for that do the following:
1. create a sample text file. you can call it "oci-shapes.txt" if you want.
2. add the following entries tot hat file (those are shape names using case sensitive):
```
VM.Standard.E3.Flex
BM.Standard.E3.128
BM.Standard2.52
BM.Standard.E2.64
BM.DenseIO2.52
BM.HPC2.36
BM.Standard1.36
VM.Standard2.1
VM.Standard2.2
VM.Standard2.4
VM.Standard2.8
VM.Standard2.16
VM.Standard2.24
VM.Standard.E2.1
VM.Standard.E2.2
VM.Standard.E2.4
VM.Standard.E2.8
VM.DenseIO2.8
VM.DenseIO2.16
VM.DenseIO2.24
VM.Standard1.1
VM.Standard1.2
VM.Standard1.4
VM.Standard1.8
VM.Standard1.16
BM.GPU2.2
VM.Standard.E2.1.Micro
VM.GPU2.1
```




3. Create a file to execute the command and take the instance shapes. you can call the file `"oci-compute-shape-list-add.sh"`

```sh
cat oci_shapes.txt | grep . |
while read shape; do
oci compute image-shape-compatibility-entry add --image-id "<image-id>" --shape-name "$shape"
done
```
4. on a computer has OCI CLI installed, give permissions to this file (oci-compute-shape-list-add.sh) in order to be able to run it and execute the script.


[//]: # (Links reference)


   [OCI CLI]: <https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm>
   [image-shape-compatibility-entry]: <https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.21.0/oci_cli_docs/cmdref/compute/image-shape-compatibility-entry.html>
   [OCI CloudShell]: <https://ocikb.com/oci-cli>




**Good Luck!**
----

![Alt text][id]

[id]: https://octodex.github.com/images/daftpunktocat-thomas.gif  "Stay Creative"



Ben
