import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class UsersService {
  constructor(private readonly databaseService: DatabaseService) {}
  async create(
    createUserDto: Prisma.UserCreateInput | Prisma.UserUncheckedCreateInput,
  ) {
    const email = createUserDto.email;
    const findedUser = await this.databaseService.user.findUnique({
      where: {
        email,
      },
    });

    if (findedUser) {
      throw new HttpException('User already exists.', HttpStatus.BAD_REQUEST);
    }

    return this.databaseService.user.create({
      data: createUserDto,
    });
  }

  async findAll() {
    return this.databaseService.user.findMany();
  }

  async findOne(id: string) {
    return this.databaseService.user.findUnique({
      where: {
        id,
      },
    });
  }

  async update(id: string, updateUserDto: Prisma.UserUpdateInput) {
    return this.databaseService.user.update({
      where: {
        id,
      },
      data: updateUserDto,
    });
  }

  async remove(id: string) {
    return this.databaseService.user.delete({
      where: {
        id,
      },
    });
  }
}
