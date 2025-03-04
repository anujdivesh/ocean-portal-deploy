<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.1.0" xmlns="http://www.opengis.net/sld"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:se="http://www.opengis.net/se"
    xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <NamedLayer>
    <se:Name>$layerName</se:Name>
    <UserStyle>
      <se:Name>LU_combined_style</se:Name>
      <se:CoverageStyle>
        <se:Rule>
          <se:RasterSymbolizer>
            <se:ColorMap>
              <!-- ColorMap based on the value ranges in your NetCDF -->
              <se:ColorMapEntry color="#e369e5" quantity="0" label="Building"/>
              <se:ColorMapEntry color="#fdbf6f" quantity="1" label="Sand/gravel"/>
              <se:ColorMapEntry color="#e31a1c" quantity="2" label="Taro"/>
              <se:ColorMapEntry color="#33a02c" quantity="3" label="Veg hi density"/>
              <se:ColorMapEntry color="#b2df8a" quantity="4" label="Veg lo density"/>
            </se:ColorMap>
          </se:RasterSymbolizer>
        </se:Rule>
      </se:CoverageStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
