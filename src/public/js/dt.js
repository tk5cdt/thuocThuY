function ValidateForm(form){
    let DIENTHOAI = form.DIENTHOAI;
    let DIACHI = form.DIACHI;
    let isValid = true

    function showError(input){
        let a = input.parentElement
        a.classList.add('invalid')
        if(input.id === 'DIENTHOAI'){
            a.querySelector('.form-message').innerHTML = ('Số điện thoại không hợp lệ')
        }
        if(input.id === 'DIACHI'){
            input.parentElement.querySelector('.form-message').innerHTML = ('Địa chỉ không hợp lệ')
        }
    }

    function valid(input) {
        input.parentElement.classList.remove('invalid')
        input.parentElement.querySelector('.form-message').innerHTML = null
        isValid = true
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
        //kiểm tra nếu chuỗi có chứa các ký tự @#$%^&*()<>?/\|{}[]~` và có độ dài < 4 thì không hợp lệ
        let regex = /[@#$%^&*()<>?/\|{}[]~`]/g
        if(regex.test(DIACHI.value) || DIACHI.value.length < 4){
            showError(DIACHI)
            isValid = false
        }
    })

    form.addEventListener('submit', function(e){
        if(DIENTHOAI.value === '' || DIENTHOAI.value == null) {
            showError(DIENTHOAI)
            isValid = false
        }
        if(DIACHI.value === '' || DIACHI.value == null) {
            showError(DIACHI)
            isValid = false
        }
        if(!isValid){
            e.preventDefault()
            alert('Please check all fields')
        }
    })
}