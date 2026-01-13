<%@ include file="/layout/head.jsp" %>

<jsp:include page="/components/navbar.jsp" />

<script src="https://cdn.tailwindcss.com"></script>

<div class="bg-white py-16 px-6">
    <div class="max-w-4xl mx-auto text-center">
        <h2 class="text-3xl font-bold text-blue-600 mb-4">Tentang Kami</h2>

        <p class="text-gray-700 text-lg leading-relaxed">
            Website e-Qurban dibuat untuk memberikan kemudahan bagi masyarakat 
            dalam membeli hewan qurban secara online. 
            Kami menyediakan berbagai pilihan sapi dan kambing yang aman, 
            sehat, dan sesuai syariat.
        </p>

        <div class="mt-10">
            <h3 class="text-xl font-semibold text-gray-800 mb-2">Visi</h3>
            <p class="text-gray-600">Menjadi platform qurban terpercaya di Indonesia.</p>

            <h3 class="text-xl font-semibold text-gray-800 mt-6 mb-2">Misi</h3>
            <p class="text-gray-600">
                Memberikan pelayanan terbaik, transparan, dan amanah dalam proses qurban.
            </p>
        </div>
        
  <section class="py-16 bg-white">
  <div class="max-w-6xl mx-auto px-4">

    <!-- Header -->
    <div class="text-center mb-12">
      <h2 class="text-3xl font-bold">Meet Our Team</h2>
      <p class="text-gray-600 mt-2">
        Dedicated professionals working together to achieve excellence
      </p>
    </div>

    <!-- Team Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">

      <!-- Member 1 -->
      <div class="text-center">
        <img src="${pageContext.request.contextPath}/image?name=hanip.jpeg"
     class="w-32 h-32 rounded-full mx-auto shadow-lg object-cover" />

        <h5 class="text-xl font-semibold mt-4">Hanip Hizbul Haq</h5>
        <p class="text-gray-500">CEO & Founder</p>
        <p class="text-gray-600 text-sm mt-2">
          Leading our company's vision and strategy with 15+ years experience.
        </p>

        <div class="flex justify-center gap-4 mt-4 text-xl text-blue-600">
          <i class="fab fa-linkedin"></i>
          <i class="fab fa-twitter"></i>
          <i class="fab fa-facebook"></i>
        </div>
      </div>

      <!-- Member 2 -->
      <div class="text-center">
            <img src="${pageContext.request.contextPath}/image?name=farel.jpeg"
     class="w-32 h-32 rounded-full mx-auto shadow-lg object-cover" />
        <h5 class="text-xl font-semibold mt-4">Muhammad Alfarel Putra</h5>
        <p class="text-gray-500">Tech Lead</p>
        <p class="text-gray-600 text-sm mt-2">
          Driving innovation and technical excellence in our projects.
        </p>

        <div class="flex justify-center gap-4 mt-4 text-xl text-blue-600">
          <i class="fab fa-linkedin"></i>
          <i class="fab fa-github"></i>
          <i class="fab fa-twitter"></i>
        </div>
      </div>

      <!-- Member 3 -->
      <div class="text-center">
           <img src="${pageContext.request.contextPath}/image?name=ammar.jpeg"
     class="w-32 h-32 rounded-full mx-auto shadow-lg object-cover" />
        <h5 class="text-xl font-semibold mt-4">Ammar Muhammad Khadafi</h5>
        <p class="text-gray-500">Design Director</p>
        <p class="text-gray-600 text-sm mt-2">
          Creating beautiful and intuitive designs loved by users.
        </p>

        <div class="flex justify-center gap-4 mt-4 text-xl text-blue-600">
          <i class="fab fa-linkedin"></i>
          <i class="fab fa-dribbble"></i>
          <i class="fab fa-instagram"></i>
        </div>
      </div>

      <!-- Member 4 -->
      <div class="text-center">
        <img src="${pageContext.request.contextPath}/image?name=cinta.jpeg"
     class="w-32 h-32 rounded-full mx-auto shadow-lg object-cover" />
        <h5 class="text-xl font-semibold mt-4">Cinta Melati</h5>
        <p class="text-gray-500">Marketing Manager</p>
        <p class="text-gray-600 text-sm mt-2">
          Developing strategies that connect our brand with audiences.
        </p>

        <div class="flex justify-center gap-4 mt-4 text-xl text-blue-600">
          <i class="fab fa-linkedin"></i>
          <i class="fab fa-twitter"></i>
          <i class="fab fa-instagram"></i>
        </div>
      </div>

    </div>
  </div>
</section>

        </div>
    </div>
