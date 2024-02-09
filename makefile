.PHONY: lambda .clean release

lambda: .clean
	mkdir -p build/
	mkdir -p lambda/
	cp -r common build
	cp lambda_startSF.py build
	cd build; zip -9qr ../start_stepf_lambda.zip *	
	
	rm -rf build/lambda_startSF.py
	cp -r bulkexecute build
	cp -r bulkmonitor build
	cp lambda_function.py build	
	cd build; zip -9qr ../bulkexecute_lambda.zip *	
	cd build; zip -9qr ../bulkmonitor_lambda.zip *		
		
	zip -9 bulkreport_lambda.zip ./lambda_email.py
	
	mv bulkexecute_lambda.zip lambda/
	mv bulkmonitor_lambda.zip lambda/
	mv bulkreport_lambda.zip lambda/
	mv start_stepf_lambda.zip lambda/

.clean:
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type d -name __pycache__ -delete
	rm -rf build
	rm -rf package
	rm -rf lambda
	rm -rf __pycache__

release: lambda
	mkdir -p package/
	cp -r lambda/ package/
	cp -r templates/ package/
	cp -r build/ package/	
	cp testlambdas.py package/
	cd package; zip -9qr ../bulkmonitor_release.zip *
