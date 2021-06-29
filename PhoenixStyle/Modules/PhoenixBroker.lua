--if IsAddOnLoaded("PhoenixBroker")==nil then
  local clickme2 = function()
  if PSFmain1:IsShown() then PSF_buttonsaveexit()
  else PhoenixStyleFailbot_Command("")end end

  local ldb = LibStub:GetLibrary("LibDataBroker-1.1")

  local dataobj = ldb:NewDataObject("PhoenixStyle",{
    type = "launcher",
    text = "PS",
    --icon = "interface\\ICONS\\inv_misc_summerfest_brazierorange",
    icon = "interface\\AddOns\\PhoenixStyle\\icon_phoenix_e",
    label = Phoen,	
    OnClick = clickme2,
      OnTooltipShow = function(tooltip)
        tooltip:AddLine("PhoenixStyle")
        if psdatabrokervart then
          tooltip:AddLine(psdatabrokervart)
        else
          tooltip:AddLine("Click = Show | Hide")
        end

      end
  })
--end