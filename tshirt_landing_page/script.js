document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('bg-animation-container');
    const shapeCount = 15;
    const shapes = ['🐱', '🐾', '✦', '✧', '⚡'];

    // Create floating elements
    for (let i = 0; i < shapeCount; i++) {
        createShape();
    }

    function createShape() {
        const shape = document.createElement('div');
        shape.className = 'floating-shape';
        shape.textContent = shapes[Math.floor(Math.random() * shapes.length)];
        
        // Random size
        const size = Math.random() * 20 + 10;
        shape.style.fontSize = `${size}px`;
        
        // Random initial position
        const posX = Math.random() * 100;
        const posY = Math.random() * 100;
        shape.style.left = `${posX}%`;
        shape.style.top = `${posY}%`;
        
        // Random color accent
        const colors = ['#00f2ff', '#ff00ff', '#7000ff', '#ffffff'];
        shape.style.color = colors[Math.floor(Math.random() * colors.length)];
        
        container.appendChild(shape);
        
        animateShape(shape);
    }

    function animateShape(el) {
        const duration = Math.random() * 20000 + 10000;
        const destX = (Math.random() - 0.5) * 200;
        const destY = (Math.random() - 0.5) * 200;
        const rotation = Math.random() * 360;

        const animation = el.animate([
            { transform: 'translate(0, 0) rotate(0deg)', opacity: 0.1 },
            { transform: `translate(${destX}px, ${destY}px) rotate(${rotation}deg)`, opacity: 0.3 },
            { transform: 'translate(0, 0) rotate(0deg)', opacity: 0.1 }
        ], {
            duration: duration,
            iterations: Infinity,
            easing: 'ease-in-out'
        });
    }

    // smooth scroll enhancement for safari
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Button hover interaction
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            btn.style.setProperty('--x', `${x}px`);
            btn.style.setProperty('--y', `${y}px`);
        });
    });
});
