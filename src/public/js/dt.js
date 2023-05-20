function ValidateForm(form){
    let dienthoai = form.DIENTHOAI;
    let DIACHI = form.DIACHI;
    let isValid = true

    function showError(input){
        input.parentElement.classList.add('invalid')
        if(input.id === 'dienthoai'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid phone number')
        }
        if(input.id === 'DIACHI'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Invalid address')
        }
    }

    function valid(input) {
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
    }

    //check valid phone number
    dienthoai.addEventListener('focus', () => {
        valid(dienthoai)
    })

    dienthoai.addEventListener('blur', function(){
        dienthoai.value = dienthoai.value.trim()
        var regexPhone = /^[0]*[0-9]{10,10}$/
        if(!regexPhone.test(dienthoai.value)){
            showError(dienthoai)
            isValid = false
        }
    })

    //check valid address
    DIACHI.addEventListener('focus', () => {
        valid(DIACHI)
    })

    DIACHI.addEventListener('blur', function(){
        DIACHI.value = DIACHI.value.trim()
        var regexAddress = /^[a-zA-Z0-9\s,.'-]{4,}$/
        if(!regexAddress.test(DIACHI.value)){
            showError(DIACHI)
            isValid = false
        }
    })

    form.addEventListener('submit', function(e){
        if(dienthoai.value === '') {
            showError(dienthoai)
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