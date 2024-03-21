import { HttpAdapterHost, NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AllExceptionsFilter } from './all-exceptions.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const { httpAdapter } = app.get(HttpAdapterHost);

  app.useGlobalFilters(new AllExceptionsFilter(httpAdapter));
  app.enableCors();

  const config = new DocumentBuilder()
    .setTitle('Journal Obliku Donativ')
    .setDescription(
      'This service is designed to improve and speed up the process of fundraising, as well as generating reports.',
    )
    .setVersion('0.0.1')
    .build();
  const document = SwaggerModule.createDocument(app, config);

  SwaggerModule.setup('api', app, document);

  await app.listen(3000);
}
bootstrap();
