const Joi = require('@hapi/joi');

const sendError = (error) => {
    if(error){
        error = error.details;
        errors = {};
        for (err of error){
            errors[err.path[0]] = err.message;
        }
        return errors;
    }else{
        return null;
    }
}

const registerValidation = (data) => {
    const schema = Joi.object({
        userName: Joi.string()
            .min(5)
            .max(255)
            .required(),
    });

    const {error} = schema.validate(data, {
        abortEarly: false
    });
    // console.log(error)
    return sendError(error);
}

const loginValidation = (data) => {
    const schema = Joi.object({
        userName: Joi.string()
            .min(5)
            .max(255)
            .required(),
    });

    const {error} = schema.validate(data, {
        abortEarly: false
    });
    // console.log(error)
    return sendError(error);
}

const noteValidation = (data) => {
    const schema = Joi.object({
        title: Joi.string()
            .min(1)
            .max(255)
            .required(),
        body: Joi.string()
            .max(1000)
            .required(),
        important: Joi.boolean(),
    });

    const {error} = schema.validate(data, {
        abortEarly: false
    });

    return sendError(error);
}


module.exports = {
    registerValidation,
    loginValidation,
    noteValidation
}