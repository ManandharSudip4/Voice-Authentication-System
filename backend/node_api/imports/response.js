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

const status_ok = "OK";
const status_fail = "Fail";
const code_ok = 200;
const code_failed = 400;
const code_unautiorized = 403;
const code_not_found = 404;
const code_error = 500;

const response = (res, stats, code, error, success, data) => {
    resp = {
        'status': stats,
        'code': code,
        'error': error,
        'success': success,
        'data': data
    }
    return res.status(code).json(resp);
}
const responseToken = (res, stats, code, error, success, data, token) => {
    resp = {
        'status': stats,
        'code': code,
        'error': error,
        'success': success,
        'data': data
    }
    return res.header('auth-token', token).status(code).json(resp);
}
module.exports = {
    errorMessage,
    successMessage,
    response,
    responseToken,
    status_ok,
    status_fail,
    code_ok,
    code_failed,
    code_unautiorized,
    code_not_found,
    code_error
}