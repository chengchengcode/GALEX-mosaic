field_name = 'DEEP23'
center_radec = '352.,-0.5'

readcol, 'NUV-LIST.txt', name, format = 'a'

data_path = '../nd/'
data_temp = 'data-temp/'

spawn, 'mkdir '+data_temp

openw, lun_exp, 'exp-sum.list', /get_lun
openw, lun_counts, 'counts-sum.list', /get_lun
openw, lun_bg, 'bg-sum.list', /get_lun
for i = 0, n_elements(name) - 1 do begin
	
	int = mrdfits(data_path+name[i]+'-int.fits.gz',0,h)
	bg = mrdfits(data_path+name[i]+'-skybg.fits.gz',0,h)
	
	exptime = int-int+sxpar(h,'EXPTIME')
	
	exptime[where(int eq 0)] = 0

	writefits, data_temp+name[i]+'-exp.fits', exptime, h
	writefits, data_temp+name[i]+'-int-counts.fits', exptime*int, h
	writefits, data_temp+name[i]+'-skybg-counts.fits', exptime*bg, h

	help, where(exptime*int lt 0)
	help, where(exptime*bg lt 0)

printf, lun_exp, data_temp+name[i]+'-exp.fits', format = '(a)'
printf, lun_counts, data_temp+name[i]+'-int-counts.fits', format = '(a)'
printf, lun_bg, data_temp+name[i]+'-skybg-counts.fits', format = '(a)'

endfor
free_lun, lun_exp
free_lun, lun_counts
free_lun, lun_bg

spawn, 'swarp @exp-sum.list -c exp-sum.swarp -CENTER '+center_radec
spawn, 'swarp @counts-sum.list -c counts-sum.swarp -CENTER '+center_radec
spawn, 'swarp @bg-sum.list -c bg-sum.swarp -CENTER '+center_radec


expmap = mrdfits('exp.fits',0,h)
bg = mrdfits('bg.fits',0,h)
counts = mrdfits('counts.fits',0,h)

stack = (counts-bg)/expmap
writefits, field_name+'-stack.fits', stack, h
stack[where(stack ne stack)] = -99.
writefits, field_name+'-stack-99.fits', stack, h





end
