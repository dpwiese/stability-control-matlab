cd C:\Program Files (x86)\FlightGear 2.4.0
SET FG_ROOT=C:\Program Files (x86)\FlightGear 2.4.0\\data
cd bin\Win32\
fgfs --aircraft=777-200ER --fdm=network,localhost,5501,5502,5503 --fog-fastest --disable-clouds --start-date-lat=2004:06:01:09:00:00 --disable-sound --in-air --enable-freeze --airport=KSFO --runway=10L --altitude=7224 --heading=113 --offset-distance=4.72 --offset-azimuth=0