function CheckCharge {
  $Report = [Windows.Devices.Power.Battery]::AggregateBattery.GetReport()
  If ($Report.Status -ne "NotPresent") {
    $MaxCharge = [convert]::ToDouble($Report.FullChargeCapacityInMilliwattHours)
    $CurrentCharge = [convert]::ToDouble($Report.RemainingCapacityInMilliwattHours)
    $BatteryPercentage = 100 * $CurrentCharge / $MaxCharge
    $Status = $Report.Status

    switch($Status) {
      "Charging" {
        if ($BatteryPercentage -gt 80) {
          [System.Windows.Forms.MessageBox]::Show("Battery charge is above 80%, stop charging")
        }
      }
      "Discharging" {
        if ($BatteryPercentage -lt 20) {
          [System.Windows.Forms.MessageBox]::Show("Battery charge is below 20%, start charging")
        }
      }
      default {
        [System.Windows.Forms.MessageBox]::Show("Failed to determine battery status, exiting")
        exit
      }

    }
  }

}


while (1 -eq 1) {
    CheckCharge
    Start-Sleep -Seconds 60
}