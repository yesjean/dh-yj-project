document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('signupForm').addEventListener('submit', handleSignUp);
    document.getElementById('loginForm').addEventListener('submit', handleLogin);
    document.getElementById('logoutButton').addEventListener('click', handleLogout);
    document.getElementById('userForm').addEventListener('submit', handleSubmit);

    checkLoginStatus();
});

async function handleSignUp(event) {
    event.preventDefault();
    const name = document.getElementById('signupName').value;
    const email = document.getElementById('signupEmail').value;
    const password = document.getElementById('signupPassword').value;

    const requestBody = { name, email, password };

    const response = await fetch('/signup', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestBody)
    });

    if (response.ok) {
        document.getElementById('signupName').value = '';
        document.getElementById('signupEmail').value = '';
        document.getElementById('signupPassword').value = '';
        alert('Sign up successful! Please log in.');
    } else {
        const errorData = await response.json();
        alert(`Sign up failed: ${errorData.error}`);
    }
}

async function handleLogin(event) {
    event.preventDefault();
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;

    const requestBody = { email, password };

    const response = await fetch('/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestBody)
    });

    if (response.ok) {
        document.getElementById('loginEmail').value = '';
        document.getElementById('loginPassword').value = '';
        alert('Login successful!');
        document.getElementById('logoutButton').style.display = 'block';
        document.getElementById('userSection').style.display = 'block';
        document.getElementById('signupForm').style.display = 'none';
        document.getElementById('loginForm').style.display = 'none';
        renderUserList();
    } else {
        const errorData = await response.json();
        alert(`Login failed: ${errorData.error}`);
    }
}

async function handleLogout() {
    const response = await fetch('/logout', {
        method: 'POST'
    });

    if (response.ok) {
        alert('Logout successful!');
        document.getElementById('logoutButton').style.display = 'none';
        document.getElementById('userSection').style.display = 'none';
        document.getElementById('signupForm').style.display = 'block';
        document.getElementById('loginForm').style.display = 'block';
        document.getElementById('userList').innerHTML = '';
        renderUserList();
    } else {
        const errorData = await response.json();
        alert(`Logout failed: ${errorData.error}`);
    }
}

async function handleSubmit(event) {
    event.preventDefault();
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;

    const requestBody = { name, email };

    const response = await fetch('/users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestBody)
    });

    if (response.ok) {
        document.getElementById('name').value = '';
        document.getElementById('email').value = '';
        renderUserList();
    }
}

async function deleteUser(userId) {
    const confirmation = confirm('Are you sure you want to delete this user?');
    if (confirmation) {
        const response = await fetch(`/users/${userId}`, {
            method: 'DELETE'
        });
        if (response.ok) {
            renderUserList();
        }
    }
}

async function editUser(userId, newName, newEmail) {
    const name = prompt('Enter new name:', newName);
    const email = prompt('Enter new email:', newEmail);
    if (name !== null && email !== null) {
        const response = await fetch(`/users/${userId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ name, email })
        });
        if (response.ok) {
            renderUserList();
        }
    }
}

async function getUsers() {
    const response = await fetch('/users');
    const data = await response.json();
    return data;
}

async function renderUserList() {
    const users = await getUsers();
    const userList = document.getElementById('userList');
    userList.innerHTML = '';
    users.forEach(user => {
        const li = document.createElement('li');
        const div = document.createElement('div');
        li.appendChild(div)
        div.textContent = `${user.name} - ${user.email}`;

        const editButton = document.createElement('button');
        editButton.textContent = 'Edit';
        editButton.addEventListener('click', () => editUser(user.id, user.name, user.email));
        li.appendChild(editButton);

        const deleteButton = document.createElement('button');
        deleteButton.textContent = 'Delete';
        deleteButton.addEventListener('click', () => deleteUser(user.id));
        li.appendChild(deleteButton);

        userList.appendChild(li);
    });
}

async function checkLoginStatus() {
    // 여기에 서버로 로그인 상태 확인 요청을 보내는 로직을 추가할 수 있습니다.
    // 로그인 상태에 따라 사용자 입력 폼과 사용자 목록을 표시하거나 숨길 수 있습니다.
}
