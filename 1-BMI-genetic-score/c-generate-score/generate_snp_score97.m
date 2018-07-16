homeDir=getenv('HOME');

dir = strcat(homeDir,'/2016-biobank-mr-phewas-bmi/data/sample500/snps/');

data = dataset('File',strcat(dir,'snp-data97.txt'), 'Delimiter', ',');


snpscore97 = (2-data.rs657452) 	* 0.023;
snpscore97 = snpscore97 + data.rs12286929 	* 0.022;
snpscore97 = snpscore97 + (2-data.rs7903146) 	* 0.023;
snpscore97 = snpscore97 + (2-data.rs10132280) 	* 0.023;
snpscore97 = snpscore97 + data.rs17094222 	* 0.025;
snpscore97 = snpscore97 + (2-data.rs7599312) 	* 0.022;
snpscore97 = snpscore97 + (2-data.rs2365389) 	* 0.020;
snpscore97 = snpscore97 + data.rs2820292 	* 0.020;
snpscore97 = snpscore97 + (2-data.rs12885454) 	* 0.021; 
snpscore97 = snpscore97 + data.rs16851483 	* 0.048;
snpscore97 = snpscore97 + data.rs1167827 	* 0.020;
snpscore97 = snpscore97 + data.rs758747 	* 0.023;
snpscore97 = snpscore97 + (2-data.rs1928295) 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs9925964) 	* 0.019;
snpscore97 = snpscore97 + data.rs11126666 	* 0.021;
snpscore97 = snpscore97 + data.rs2650492 	* 0.021;
snpscore97 = snpscore97 + data.rs6804842 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs4740619) 	* 0.018;
snpscore97 = snpscore97 + (2-data.rs13191362) 	* 0.028;
snpscore97 = snpscore97 + (2-data.rs3736485) 	* 0.018;
snpscore97 = snpscore97 + data.rs17001654 	* 0.031;
snpscore97 = snpscore97 + data.rs11191560 	* 0.031;
snpscore97 = snpscore97 + data.rs1528435 	* 0.018;
snpscore97 = snpscore97 + data.rs1000940 	* 0.019;
snpscore97 = snpscore97 + data.rs2033529 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs11583200) 	* 0.018;
snpscore97 = snpscore97 + data.rs9400239 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs10733682) 	* 0.017;
snpscore97 = snpscore97 + (2-data.rs11688816) 	* 0.017;
snpscore97 = snpscore97 + (2-data.rs11057405) 	* 0.031;
snpscore97 = snpscore97 + (2-data.rs11727676) 	* 0.036;
snpscore97 = snpscore97 + data.rs3849570 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs6477694) 	* 0.017;
snpscore97 = snpscore97 + data.rs7899106 	* 0.040;
snpscore97 = snpscore97 + (2-data.rs2176598) 	* 0.020;
snpscore97 = snpscore97 + (2-data.rs2245368) 	* 0.032;
snpscore97 = snpscore97 + (2-data.rs17724992) 	* 0.019;
snpscore97 = snpscore97 + (2-data.rs7243357) 	* 0.022;
snpscore97 = snpscore97 + data.rs2033732 	* 0.019;
snpscore97 = snpscore97 + data.rs1558902 	* 0.082;
snpscore97 = snpscore97 + data.rs6567160 	* 0.056;
snpscore97 = snpscore97 + data.rs13021737 	* 0.06;
snpscore97 = snpscore97 + data.rs10938397 	* 0.04;
snpscore97 = snpscore97 + data.rs543874	* 0.048;
snpscore97 = snpscore97 + data.rs2207139 	* 0.045;
snpscore97 = snpscore97 + (2-data.rs11030104) 	* 0.041;
snpscore97 = snpscore97 + data.rs3101336 	* 0.033;
snpscore97 = snpscore97 + data.rs7138803 	* 0.032;
snpscore97 = snpscore97 + data.rs10182181 	* 0.031;
snpscore97 = snpscore97 + data.rs3888190 	* 0.031;
snpscore97 = snpscore97 + data.rs1516725 	* 0.045;
snpscore97 = snpscore97 + (2-data.rs12446632) 	* 0.04;
snpscore97 = snpscore97 + (2-data.rs2287019) 	* 0.036;
snpscore97 = snpscore97 + (2-data.rs16951275) 	* 0.031;
snpscore97 = snpscore97 + data.rs3817334 	* 0.026;
snpscore97 = snpscore97 + (2-data.rs2112347) 	* 0.026;
snpscore97 = snpscore97 + (2-data.rs12566985) 	* 0.024;
snpscore97 = snpscore97 + data.rs3810291 	* 0.028;
snpscore97 = snpscore97 + data.rs7141420 	* 0.024;
snpscore97 = snpscore97 + data.rs13078960 	* 0.03;
snpscore97 = snpscore97 + data.rs10968576 	* 0.025;
snpscore97 = snpscore97 + data.rs17024393 	* 0.066;
snpscore97 = snpscore97 + data.rs12429545 	* 0.033;
snpscore97 = snpscore97 + data.rs13107325 	* 0.048;
snpscore97 = snpscore97 + data.rs11165643 	* 0.022;
snpscore97 = snpscore97 + (2-data.rs17405819) 	* 0.022;
snpscore97 = snpscore97 + (2-data.rs1016287) 	* 0.023;
snpscore97 = snpscore97 + data.rs4256980 	* 0.021;
snpscore97 = snpscore97 + data.rs12401738 	* 0.021;
snpscore97 = snpscore97 + data.rs205262 	* 0.022;
snpscore97 = snpscore97 + data.rs9581854 * 0.03; % rs12016871
snpscore97 = snpscore97 + (2-data.rs12940622) 	* 0.018;
snpscore97 = snpscore97 + data.rs11847697 	* 0.049;
snpscore97 = snpscore97 + (2-data.rs2075650) 	* 0.026;
snpscore97 = snpscore97 + data.rs2121279 	* 0.025;
snpscore97 = snpscore97 +  data.rs29941 	* 0.018;
snpscore97 = snpscore97 + (2-data.rs1808579) 	* 0.017;

% extra SNPs from secondary analysis of Locke paper
snpscore97 = snpscore97 + data.rs9641123 	* 0.029;
snpscore97 = snpscore97 + (2-data.rs492400) 	* 0.024;
snpscore97 = snpscore97 + (2-data.rs7239883) 	* 0.023;
snpscore97 = snpscore97 + data.rs9374842 	* 0.023;
snpscore97 = snpscore97 +  data.rs4787491 	* 0.022;
snpscore97 = snpscore97 +  (2-data.rs16907751) 	* 0.047;
snpscore97 = snpscore97 +  (2-data.rs9540493) 	* 0.021;
snpscore97 = snpscore97 +  data.rs6465468 	* 0.025;
snpscore97 = snpscore97 +  (2-data.rs6091540)	* 0.030;
snpscore97 = snpscore97 +  (2-data.rs2176040) 	* 0.024;
  
snpscore97 = snpscore97 +  data.rs7164727	* 0.019;
snpscore97 = snpscore97 +  (2-data.rs2080454)	* 0.017;
snpscore97 = snpscore97 +  data.rs2836754	* 0.017;
snpscore97 = snpscore97 +  data.rs9914578	* 0.020;
snpscore97 = snpscore97 +  (2-data.rs977747)	* 0.017;
snpscore97 = snpscore97 +  data.rs1441264	* 0.017;
snpscore97 = snpscore97 +  data.rs17203016	* 0.021;
snpscore97 = snpscore97 +  data.rs13201877	* 0.024;
snpscore97 = snpscore97 +  data.rs1460676	* 0.021;
snpscore97 = snpscore97 +  (2-data.rs7715256) 	* 0.017;

dlmwrite(strcat(dir,'snp-score97.txt'), [double(data(:,1)) snpscore97], 'precision', 16);






