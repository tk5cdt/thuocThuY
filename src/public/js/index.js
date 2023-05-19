
function ValidateForm(form)
{
    var email = form.email
    var password = form.password
    var isValid = true

    function showError(input){
        input.parentElement.classList.add('invalid')
        if(input.id === 'email'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid email')
        }
        if(input.id === 'password'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid password')
        }
    }

    function valid(input) {
        isValid = true
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
    }

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
        if(!isValid){
            e.preventDefault()
            alert('Please fill in all fields')
        }
        else{
            //go to bai5b.html
            window.location.href = 'bai5b.html'
        }
    })
}

let submit = document.querySelector('.form-submit')
submit.addEventListener('click', function(){
    var email = document.querySelector('#email')
    localStorage.setItem('email', email.value)
})
