exports.createTransit = async (isFarmer, isAuditor, isTransporter, information) => {
    const {
        arrivalTime,
        typeOfStorage,
        depCoordinates,
        destCoordinates,
        meatMat,
        storageTime,
        shippingMethod,
        transporterMat,
        footprint,
        status,
    } = information;

    const networkObj = await network.connect(false, false, true, id);
    const contractRes = await network.invoke(
        networkObj,
        'createTransit ',
        arrivalTime,
        typeOfStorage,
        depCoordinates,
        destCoordinates,
        meatMat,
        storageTime,
        shippingMethod,
        transporterMat,
        footprint,
        status,
    );
    console.log(contractRes);
    const error = networkObj.error || contractRes.error;
    if (error) {
        const status = networkObj.status || contractRes.status;
        return apiResponse.createModelRes(status, error);
    }
    return apiResponse.createModelRes(200, 'Success', contractRes);
};

exports.getAllTransit = async (isFarmer, isAuditor, isTransporter, information) => {
    const { userMat } = information;

    const networkObj = await network.connect(isFarmer, isAuditor, isTransporter, farmerMat);
    const contractRes = await network.invoke(networkObj, 'queryAllTransit', userMat);

    const error = networkObj.error || contractRes.error;
    if (error) {
        const status = networkObj.status || contractRes.status;
        return apiResponse.createModelRes(status, error);
    }

    return apiResponse.createModelRes(200, 'Success', contractRes);
};
