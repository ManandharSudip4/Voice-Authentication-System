const errorMessage = (err) => {
    error = {
        "error": err
    }
    return error;
} 

const successMessage = (suc) => {
    success = {
        "success": suc
    }
    return success;
} 
module.exports = {
    errorMessage,
    successMessage
}