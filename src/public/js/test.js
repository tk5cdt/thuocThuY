
function ValidateForm(form)
{
    var fullname = form.username
    var email = form.email
    var password = form.password
    var password_confirmation = form.re-password
    var isValid = true

    function showError(input){
        input.parentElement.classList.add('invalid')
        if(input.id === 'fullname'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid name')
        }
        if(input.id === 'email'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid email')
        }
        if(input.id === 'password'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid password')
        }
        if(input.id === 'password_confirmation'){
            if(password_confirmation.value.length === 0){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid password confirmation')
            }
            else{
                input.parentElement.querySelector('.form-message').innerHTML = ('Password confirmation does not match')
            }
        }
    }

    function valid(input) {
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
    }

    //check valid fullname
    fullname.addEventListener('focus', () => {
        valid(fullname)
    })

    fullname.addEventListener('blur', function(){
        fullname.value = fullname.value.trim()
        //check if name has special characters and length < 10 then show error, name can have space
        var regexName = /^[a-zA-Z0-9 ]{10,}$/
        if(!regexName.test(fullname.value)){
            showError(fullname)
            isValid = false
        }
    })

    //check valid email
    email.addEventListener('focus', () => {
        valid(email)
    })

    email.addEventListener('blur', function(){
        email.value = email.value.trim()
        var regexEmail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
        if(!regexEmail.test(email.value)){
            showError(email)
            isValid = false
        }
    })

    //check valid password
    password.addEventListener('focus', () => {
        valid(password)
    })

    password.addEventListener('blur', function(){
        password.value = password.value.trim()
        var regexPassword = /^[a-zA-Z0-9]{10,}$/
        if(!regexPassword.test(password.value)){
            showError(password)
            isValid = false
        }
    })

    //check valid password_confirmation
    password_confirmation.addEventListener('focus', () => {
        valid(password_confirmation)
    })

    password_confirmation.addEventListener('blur', function(){
        password_confirmation.value = password_confirmation.value.trim()
        if(password_confirmation.value.length === 0){
            showError(password_confirmation)
            isValid = false
        }
        if(password_confirmation.value !== password.value){
            showError(password_confirmation)
            isValid = false
        }
    })

    //check all empty
    function isEmpty(input){
        input.value.trim()
        if(input.value === ''){
            showError(input)
            isValid = false
        }
    }
    form.addEventListener('submit', function(e){
        //if email or password is empty or invalid, prevent submit
        isEmpty(email)
        isEmpty(fullname)
        isEmpty(password_confirmation)
        isEmpty(password)
        if(!isValid){
            e.preventDefault()
            alert('Please fill in all fields')
        }
    })
}