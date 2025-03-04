import netCDF4 as nc
import numpy as np
import configparser
import os

number_attributes = ['valid_min', 'valid_max', 'QC_indicator', 'QC_procedure']

class OceanoDataset(nc.Dataset):


    def __init__(self, filename, mode='r', type_mesure = None, nb_profil=None, **kwargs):

        super().__init__(filename, mode, **kwargs)

        if mode == 'w':

            if type_mesure is None:
                raise ValueError('Argument type_mesure must be defined in writing mode')

            config = configparser.RawConfigParser()
            config.optionxform=str # preserve case

            config.read('/opt/airflow/plugins/confs/netcdf.cfg')

            # GLOBAL ATTRIBUTES
            global_attributes = config['GLOBAL']

            if type_mesure == 'SERIE':
                self.data_type = 'OceanSITES time-series data'
                self.cdm_data_type = 'station'
            elif type_mesure == 'PROFIL':
                self.data_type = 'OceanSITES profile data'
                self.cdm_data_type = 'profile'
            elif type_mesure == 'TRAJECT':
                self.data_type = 'OceanSITES trajectory data'
                self.cdm_data_type = 'trajectory'

            for attribute, value in global_attributes.items():
                setattr(self, attribute, value)

            # REFERENCE DATE 
            self.createDimension('STRING14', 14)
            ref_date = self.createVariable('REFERENCE_DATE_TIME', 'S1', ('STRING14'))
            ref_date_attributes = config['REFERENCE_DATE_TIME']
            for attribute, value in ref_date_attributes.items():
                if attribute != 'value':
                    setattr(ref_date, attribute, value)
            ref_date[:] = nc.stringtochar(np.array(ref_date_attributes['value'], 'S'))

            # TIME
            if type_mesure in ['SERIE','TRAJECT']:
                self.createDimension('TIME')
            elif type_mesure == 'PROFIL':
                self.createDimension('PROFILE', nb_profil)
                self.createDimension('TIME', nb_profil)
            time_var = self.createVariable('TIME', 'f8', ('TIME'))
            time_attributes = config['TIME']
            for attribute, value in time_attributes.items():
                if attribute in number_attributes:
                    value = float(value)
                setattr(time_var, attribute, value)

            # LATITUDE, LONGITUDE
            if type_mesure in ['SERIE', 'PROFIL']:
                self.createDimension('LATITUDE', 1)
                self.createDimension('LONGITUDE', 1)
                lat_var_dim = ('LATITUDE')
                lon_var_dim = ('LONGITUDE')
            elif type_mesure == 'TRAJECT':
                lat_var_dim = ('TIME')
                lon_var_dim = ('TIME')

            lat_attributes = config['LATITUDE']
            lat_var = self.createVariable('LATITUDE', 'f8', lat_var_dim)
            for attribute, value in lat_attributes.items():
                if attribute in number_attributes:
                    value = float(value)
                setattr(lat_var, attribute, value)

            lon_attributes = config['LONGITUDE']
            lon_var = self.createVariable('LONGITUDE', 'f8', lon_var_dim)
            for attribute, value in lon_attributes.items():
                if attribute in number_attributes:
                    value = float(value)
                setattr(lon_var, attribute, value)

            # DEPTH
            depth_attributes = config['DEPTH']
            if type_mesure in ['SERIE','TRAJECT']:
                self.createDimension('DEPTH', 1)
            elif type_mesure == 'PROFIL':
                self.createDimension('DEPTH')

            depth_var = self.createVariable('DEPTH', 'f8', ('DEPTH'), fill_value=depth_attributes['_FillValue'])
            for attribute, value in depth_attributes.items():
                if attribute != '_FillValue':
                    if attribute in number_attributes:
                        value = float(value)
                    setattr(depth_var, attribute, value)


    def createVariable(self, varname, datatype, dimensions=(), **kwargs):

        var = super().createVariable(varname, datatype, dimensions, **kwargs)

        if varname[-3:] == '_QC':
            config = configparser.RawConfigParser()
            config.read('/opt/airflow/plugins/confs/netcdf.cfg')
            qc_attributes = config['QC']
            for attribute, value in qc_attributes.items(): 
                if attribute != 'flag_values':
                    if attribute in number_attributes:
                        value = float(value)
                    setattr(var, attribute, value)
                else:
                    setattr(var, attribute, [int(num) for num in qc_attributes['flag_values'].split(', ')])
    
        return var



