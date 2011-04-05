# ===========================================================================
# Project:   ElectricCalculator
# Copyright: ©2011 CarbonCalculated.
# ===========================================================================

# Add initial buildfile information here
config :all, :required => "sproutcore/core_foundation", :theme => "sproutcore/empty_theme"
proxy "/electric_bills", :to => "localhost:4567"
require 'fancy-buttons'
  