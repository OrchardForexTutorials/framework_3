# Orchard Framework 3

## v3.01
- Fix error in PositionInfo_mql4 where SelectByIndex should have returned a boolean but was instead returning an integer
- Added code to the ExpertBase class needed for grid trading
- Added a leg class inheriting from expert base also useful for grid trading but has other uses to be reviewed later
- Changed generic framework file to handle version numbers differently making selection in a project easier

## v3.00
Release 3.00 is the basic start of the framework. There will be additions as new versions as new features are needed.

Due to the way this is being evolved over time version numbering will differ a little from normal conventions.

All version numbers in this repository will begin with 3. Think of it more like a product number than a version number.

As new versions are released they will be in separate folders within MQL to make the code between versions immutable. You can then select to use any version you wish.

in case there are bug fixes that need to be adjusted in older versions there will be no release number issued here, only internal fix numbers.
