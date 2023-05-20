
function ValidateForm(form)
{
    var username = form.username
    var email = form.email
    var password = form.password
    var rePassword = form.rePassword
    var isValid = true

    function showError(input){
        input.parentElement.classList.add('invalid')
        if(input.id === 'email'){
            input.parentElement.querySelector('.form-message').innerHTML = ('email có dạng abc@abc.com')
        }
        if(input.id === 'password'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid password')
        }
        if(input.id === 'username'){
            input.parentElement.querySelector('.form-message').innerHTML = ('username phải từ 5 ký tự trở lên')
        }
        if(input.id === 'rePassword'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid rePassword')
        }
    }

    function valid(input) {
        isValid = true
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
    }

    //check valid username
    username.addEventListener('focus', () => {
        valid(username)
    })

    username.addEventListener('blur', function(){
        username.value = username.value.trim()
        var regexUsername = /^[a-zA-Z0-9]{6,}$/
        if(!regexUsername.test(username.value)){
            showError(username)
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
        var regexPassword = /^[a-zA-Z0-9]{6,}$/
        if(!regexPassword.test(password.value)){
            showError(password)
            isValid = false
        }
    })

    //check valid rePassword
    rePassword.addEventListener('focus', () => {
        valid(rePassword)
    })

    rePassword.addEventListener('blur', function(){
        rePassword.value = rePassword.value.trim()
        if(rePassword.value !== password.value || rePassword.value === ''){
            showError(rePassword)
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
        isEmpty(password)
        isEmpty(username)
        isEmpty(rePassword)
        if(!isValid){
            e.preventDefault()
            alert('Please check all fields')
        }
    })
}
