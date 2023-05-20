function ValidateForm(form){
    let DIENTHOAI = form.DIENTHOAI;
    let DIACHI = form.DIACHI;
    let isValid = true

    function showError(input){
        let a = input.parentElement
        a.classList.add('invalid')
        if(input.id === 'DIENTHOAI'){
            a.querySelector('.form-message').innerHTML = ('Invalid phone number')
        }
        if(input.id === 'DIACHI'){
            input.parentElement.querySelector('.form-message').innerHTML = 'Invalid address'
        }
    }

    function valid(input) {
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
    }

    //check valid phone number
    DIENTHOAI.addEventListener('focus', () => {
        valid(DIENTHOAI)
    })

    DIENTHOAI.addEventListener('blur', function(){
        DIENTHOAI.value = DIENTHOAI.value.trim()
        var regexPhone = /^[0]*[0-9]{10,10}$/
        if(!regexPhone.test(DIENTHOAI.value)){
            showError(DIENTHOAI)
            isValid = false
        }
    })

    //check valid address
    DIACHI.addEventListener('focus', () => {
        valid(DIACHI)
    })

    DIACHI.addEventListener('blur', function(){
        DIACHI.value = DIACHI.value.trim()
        var regexAddress = /^[a-zA-Z0-9\s,.'-]{4,}$/u;
        if(!regexAddress.test(DIACHI.value)){
            showError(DIACHI)
            isValid = false
        }
    })

    form.addEventListener('submit', function(e){
        if(DIENTHOAI.value === '') {
            showError(DIENTHOAI)
            isValid = false
        }
        if(DIACHI.value === '') {
            showError(DIACHI)
            isValid = false
        }
        if(!isValid){
            e.preventDefault()
            alert('Please check all fields')
        }
    })
}