split -b 256M /data/swapfile ./fio_test_file. 
mv fio_test_file.aa fio_test_file.0.0
mv fio_test_file.ab fio_test_file.1.0
mv fio_test_file.ac fio_test_file.2.0
mv fio_test_file.ad fio_test_file.3.0
