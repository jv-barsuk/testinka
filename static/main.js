document.addEventListener("DOMContentLoaded", main())

function main() {
    setTimeout(addButtonFunction, 2000)
}

function addButtonFunction() {    
    Array.from(document.getElementsByTagName("button")).forEach(button => {
        button.addEventListener("click", (event) => {
            let children = Array.from(event.target.parentNode.children)
            children.forEach(child => {
                toggleDisplay(child)
            })
            button.style.display = "inline"
        })
    });
}

function toggleDisplay(element) {
    console.log(element.style.display)
    if(element.style.display == "none" || element.style.display == undefined) {
        console.log("in")
        element.style.display="inline"
    } else {
        element.style.display="none"
    }
}